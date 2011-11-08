# An Overlay for Automatic Theorem Provers

## How to Use
Edit your `/etc/layman/layman.conf`

    #-----------------------------------------------------------
    # URLs of the remote lists of overlays (one per line) or
    # local overlay definitions
    #
    #overlays  : http://www.gentoo.org/proj/en/overlays/repositories.xml
    #            http://dev.gentoo.org/~wrobel/layman/global-overlays.xml
    #            http://mydomain.org/my-layman-list.xml
    #            file:///var/lib/layman/my-list.xml
    
    overlays  : http://www.gentoo.org/proj/en/overlays/repositories.xml
                https://raw.github.com/na4zagin3/proof-overlay/master/overlay.xml # add this line!


