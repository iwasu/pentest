# Replace the computername with the actual computername

 

Add-Type -AssemblyName System.DirectoryServices.AccountManagement
$DS = New-Object System.DirectoryServices.AccountManagement.PrincipalContext('domain')

 

function Test-ADCredential {
    Param
        (
            [string]$UserName,
            [string]$Password
        )
    if (!($UserName) -or !($Password)) {
        Write-Warning 'Test-ADCredential: Please specify both user name and password'
    } else {
        Write $UserName $Password 
        $DS.ValidateCredentials($UserName, $Password)
    }
}

 

# Enterprise admins
function Login (){
Test-ADCredential "admin2011" "P@ssw0rd"

# domain admins"
Test-ADCredential "Acrobat6std" "P@ssw0rd"

}

 

Export-ModuleMember -Function 'Login'