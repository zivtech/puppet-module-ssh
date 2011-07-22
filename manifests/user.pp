define ssh::user($ensure=present, $key, $comment="") {

  if $ensure == present {
    File["/home/$name"] -> Ssh_authorized_key["${name}@${comment}"]
  } else {
    Ssh_authorized_key["${name}@${comment}"] -> User[$name]
    Ssh_authorized_key["${name}@${comment}"] -> Group[$name]
  }

  ssh_authorized_key { "${name}@${comment}":
    ensure  => $ensure,
    key => $key,
    target  => "/home/$name/.ssh/authorized_keys",
    user  => $name,
    type  => "ssh-rsa",
  }
}