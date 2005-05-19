From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: Netserver 1000r and Serverworks OSB4 specs
Message-Id: <3C926EC7.59859F98@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1016214655.1576.23.camel@mattb.fc.hp.com>
In-Reply-To: <1016214655.1576.23.camel@mattb.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As far as we know the OSB4 support works fine, so the problem is presumably
with chips on the SMBus that we don't support?
It's not something on the ISA/PCI bus?

Them telling you what the chips are shouldn't require an NDA...
or you can look at the board...
Or do you already know it is some proprietary sensor chip?

Of course we would welcome a donation...



Matthew Brichacek wrote:
> 
> Hello,
>         I have recently tried to get my serverworks osb4 mb to register your
> drivers.  I was able to get the PIIx4 driver to load and recognize the
> SMBus, however no chips are recognized.  I was able to get ServerWorks
> to release the specs to me for their I2C and SMBus stuff.  I am working
> out the details of the confidentiality agreement with them right now.
> If I was able to provide you with the specs and some hardware could you
> make use of this to complete support for this MB and the chips on it?
> 
> Thanks
> 
> Matthew
> 
> --
> Matthew M. Brichacek
> Linux Development Lab R&D Engineer
> Hewlett Packard Company
> 3404 Harmony Road
> Ft. Collins, Colorado 80528-9599
> Phone: (970) 898-7346
> email: mmbrich@ldl.fc.hp.com
>               __
>              / /\
>             / /  \
>     __     /_/ /\ \
>    /_/\  __\ \ \_\ \
>    \ \ \/ /\\ \ \/ /
>     \ \ \/  \\ \  /
>      \ \  /\ \\ \ \
>       \ \ \ \ \\ \ \
>        \ \ \_\/ \ \ \
>         \ \ \    \_\/
>          \_\/
>         i n v e n t
