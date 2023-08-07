#Metasploit
require 'msf/core'
class MetasploitModule < Msf::Auxiliary
  include Msf::Exploit::Remote::Tcp
  include Msf::Auxiliary::Scanner
  def initialize
    super(
      'Name' => 'My custom TCP scan',
	    'Version' => '$Revision: 1 $',
	    'Description' => 'My quick scanner',
	    'Author' => 'nknskn',
	    'Lisence' => MSF_LICENSE
	   )
	   register_options(
       [
         #Opt::RHOSTS(192.168.0.1)
         Opt::RPORT(12345)
	     ], self.class)
  end

  def run_host(ip)
    connect()
	  sock.puts('HELLO SERVER')
	  data = sock.recv(1024)
	  print_status("Received: #{data} from #{ip}")
    disconnect()
  end
end