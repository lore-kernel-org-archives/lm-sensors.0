From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Ticket #: 910: missing " in sensors-detect
Message-Id: <3D0749A5.2641015C@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D06E2EB.4040007@stud.uni-goettingen.de>
In-Reply-To: <3D06E2EB.4040007@stud.uni-goettingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

duh, sorry,
don't know why I was thinking sensors.conf.
I'll fix it tonight.

For mail list email phil@netroedge.com

Tobias Edler wrote:
> 
> Hi !
> The problem is in sensors-detect, not in sensors.conf. in the CVS version.
> I just checked lm-sensors2 out via cvs, an the problem is still there.In
> prog/detect/sensors-detect in line 104, there's a " missing at the end
> of the statement:
> 
> quote from the file:
> 
>   {
>        vendid => 0x8086,
>        devid  => 0x24C3,
>        func => 3,
>        procid => "Intel 82801DB ICH4, <-- This is line 104.
>        driver => "i2c-i801",
>        match => sub { $_[0] =~ /^SMBus I801 adapter at [0-9,a-f]{4}/ },
>      } ,
> 
> when I try to run prog/detect/sensors-detect, all I get is al long list
> of errors, "might be a run-away string from line ..."
> 
> BTW: how can I join the ML ? I found nothing on the homepage.
> 
> Regards from Germany
> --
> ________
> \  |      GPG (PGP) Key: www.stud.uni-goettingen.de/~s242275/pgpkey.pub
>  \ |--    Jabber-ID at a-message.de: te_linuxguru
>   \|____  ICQ: 124557012
