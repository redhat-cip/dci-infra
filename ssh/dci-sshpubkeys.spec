%global username dci

Name:           dci-sshpubkeys
Version:        0.1
Release:        1%{?dist}

Summary:        Distributed CI Team SSH public keys
License:        ASL2.0
URL:            https://github.com/redhat-cip/dci-control-server

BuildArch:      noarch

Requires(pre):  shadow-utils
Requires:       sudo

%description
This package contain the public keys of the Distributed CI team members

%prep

%build

%install
install -d  %{buildroot}/%{_sysconfdir}/sudoers.d
install -d -m 700 %{buildroot}/home/%{username}/.ssh
cat > %{buildroot}/home/%{username}/.ssh/authorized_keys <<EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWv/UQpO7kT/6iPbD2t2svKRqM6iaamSWarY6wnrkd9r9HBhBpQTWgyi3TVXIhAt/wW9oWB8kc7sdmB4jOaJA4D3Kq31WxTY2WnWuBzE0Ojns7iMB2k4HRZHQHXC0L0QZ1eE15jrqD//VhHf4K8zEG3otMELMpICPLRfoUGkCeJHHxEpc3Xhk1N+rarcNklEhtnQaO+44hk9xy9W+bRvQ9L2epDznfJDiB3mb+pzRsH1T0awfY/eUedIWWnqBq4gtIIsa7kkUOtJkjmBk86K9fccGA06pyIz48FNotjZ1OOdredI5vb80o4X1TTMvi/E2ZYjOU2zhVqoegkLwVvpXT yassine@Bouceka
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDMojr5FJS9LuK27pVK5zQARZo9mEEsJ6HiyRiiVlZnaJaY6ZCVHMwnb07EyCJtN8fBd7JXUbVGevZnDzEzDRWMMd7zUGqMtiNABiFHiOA0+sNDBWs3gb5VD/IOkbnY/ocW4uiUAAan0n6O97cKBjYEwhv6TlrLSHe78EjU0Nb1AYMKkKYYA097D51wZnpGPVCgmBMQ5WgZNnaqskSKFocqoPzJnldoz6tVtzu5jKxMnaXAaCBChD8XqVYkbfVPBg+kgvSKj9sIZbCpjGyA6pUvzAAbCKaJKninSEs5zWL9CpI1dQMYNdrI+MIJn39vw5cA9RbceDvlPd/6scxOshBn maxime.vidori@gmail.com
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCyiXfE1zHKdj6odbysr917Cn88ov0VQaPJtLKJyMNuRYAeMOFQHd50X8JO4dfZbmSo3YdJlVfz9FLRxE64mqj9bkN8hPFbkTG2F1AWXGPON5cmm4uiLPfQkWhX/LnClrhzZpNtMJYs5AEFeDs0POijcRugZsQA+wvLi0lSlhOfkqtjAJKpPUwy1wrJFDdvqdQBjpNQh/LB8c15XfQV2JT/3NX26dQe8zvHhL6NvfhBnAikodYkBr7UjSl36CBk0cPebZMZEBBiHdo76xORVkpmqDvkhFByXXeAsvRa2YWS4wxpiNJFswlRhjubGau7LrT113WMcPvgYXHYHf2IYJWD goneri@redhat.com
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+ZFQv3MyjtL1BMpSA0o0gIkzLVVC711rthT29hBNeORdNowQ7FSvVWUdAbTq00U7Xzak1ANIYLJyn+0r7olsdG4XEiUR0dqgC99kbT/QhY5mLe5lpl7JUjW9ctn00hNmt+TswpatCKWPNwdeAJT2ERynZaqPobENgvIq7jfOFWQIVew7qFeZygxsPVn36EUr2Cdq7Nb7U0XFXh3x1p0v0+MbL4tiJwPlMAGvFTKIMt+EaA+AsRIxiOo9CMk5ZuOl9pT8h5vNuEOcvS0qx4v44EAD2VOsCVCcrPNMcpuSzZP8dRTGU9wRREAWXngD0Zq9YJMH38VTxHiskoBw1NnPz spredzy@murcia.yanisguenane.fr
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbQZ+OSb/5+SWnnNB+rJyU01kx+ZkYBZyAofEz48kdCA4ikAbrayNa/yG1pM7KBqtJLotdpYLoLbGonVseHbuk8GDo6Axue0YLDPuTAYvFjiGjKK8jOIKrbdMnN7mfFhqJ/cAFow41Aa3wGoBPBdtzH15m+TkXvQ0O1H7wS2MRcLqtpZK86s+HpXZSuicV89tJDdm1fehtSGw9uof0fLv61sSn5OOidIu3rGACLl5Sqq9h3/8SffaY52hhU3WlJob/mMo6V54ceprvdeyS42dzwSg6dJY7jrmmvfxiAKSWm4qo4GmpPC3qWcXrPVv/Om37TUMJp6sqAb+CCc884ber dciagent@jenkins
EOF
cat > %{buildroot}/%{_sysconfdir}/sudoers.d/dci-user <<EOF
# User rules for dci user
dci ALL=(ALL) NOPASSWD:ALL
EOF

%files
%defattr(-,root,root,-)
%{_sysconfdir}/sudoers.d/dci-user
%attr(600, %{username}, %{username}) /home/%{username}/.ssh
%attr(600, %{username}, %{username}) /home/%{username}/.ssh/authorized_keys

%pre
getent group %{username} >/dev/null || groupadd -r %{username}
getent passwd %{username} >/dev/null || \
    useradd -r -g %{username} -s /bin/bash \
    -c "The DCI user" %{username}
exit 0

%changelog
* Tue Nov 17 2015 Yanis Guenane <yguenane@redhat.com> 0.1-1
- Initial commit

