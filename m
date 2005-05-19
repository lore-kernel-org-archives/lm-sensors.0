From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: asb100 Bach
Message-Id: <3D25A5DE.F1C77971@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D09D5C4.7070200@stud.uni-goettingen.de>
In-Reply-To: <3D09D5C4.7070200@stud.uni-goettingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

that's actually quite promising.
Do you have another driver (lm75?) already loaded which has registered
at 0x49?
rmmod that driver first and try again.



Tobias Edler wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Mark M. Hoffman wrote:
> | So, I might suggest you try to force the w83781d driver (which
> | handles AS99127F) at 0x2D and see what happens.  I cannot test this
> | myself, since I cannot even access the SMBus for my board.  Please
> | let me know if this works.
> no. it doesn't.
> 
> says:
> subclient 0 registration at adress 0x49 failed.
> 
> - --
> ________
> \  |      GPG (PGP) Key: www.stud.uni-goettingen.de/~s242275/pgpkey.pub
> ~ \ |--    Jabber-ID at a-message.de: te_linuxguru
> ~  \|____  ICQ: 124557012
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.7 (GNU/Linux)
> 
> iD8DBQE9JTv7KpMiVYRJv9YRAtcLAKCBi5UTpnBX468I2ZWUNjySlISKNACeOjAe
> 7UWej3cCp0/llaf3hvNPKIE> =/ly1
> -----END PGP SIGNATURE-----
