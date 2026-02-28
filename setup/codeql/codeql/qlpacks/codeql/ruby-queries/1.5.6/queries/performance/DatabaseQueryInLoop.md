# Database query in a loop
When a database query operation, for example a call to a query method in the Rails \`ActiveRecord::Relation\` class, is executed in a loop, this can lead to a performance issue known as an "n+1 query problem". The database query will be executed in each iteration of the loop. Performance can usually be improved by performing a single database query outside of a loop, which retrieves all the required objects in a single operation.


## Recommendation
If possible, pull the database query out of the loop and rewrite it to retrieve all the required objects. This replaces multiple database operations with a single one.


## Example
The following (suboptimal) example code queries the `User` object in each iteration of the loop:


```ruby
repo_names_by_owner.map do |owner_slug, repo_names|
    owner_id, owner_type = User.where(login: owner_slug).pluck(:id, :type).first
    owner_type = owner_type == "User" ? "USER" : "ORGANIZATION"
    rel_conditions = { owner_id: owner_id, name: repo_names }

    nwo_rel = nwo_rel.or(RepositorySecurityCenterConfig.where(rel_conditions)) unless neg
    nwo_rel = nwo_rel.and(RepositorySecurityCenterConfig.where.not(rel_conditions)) if neg
  end
```
To improve the performance, we instead query the `User` object once outside the loop, gathering all necessary information in a single query:


```ruby
# Preload User data
user_data = User.where(login: repo_names_by_owner.keys).pluck(:login, :id, :type).to_h do |login, id, type|
  [login, { id: id, type: type == "User" ? "USER" : "ORGANIZATION" }]
end

repo_names_by_owner.each do |owner_slug, repo_names|
  owner_info = user_data[owner_slug]
  owner_id = owner_info[:id]
  owner_type = owner_info[:type]
  rel_conditions = { owner_id: owner_id, name: repo_names }

  nwo_rel = nwo_rel.or(RepositorySecurityCenterConfig.where(rel_conditions)) unless neg
  nwo_rel = nwo_rel.and(RepositorySecurityCenterConfig.where.not(rel_conditions)) if neg
end
```
