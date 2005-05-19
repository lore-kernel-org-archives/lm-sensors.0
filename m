From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: Fw: Ask for some information about motherboard ASUS NCLV-D
Message-Id: <Pine.LNX.4.58.0503261328400.20694@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE08BE5D@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> I have two questions here:
> (1) As we know, it will be very inconvenient for those users with ASUS
> NCLV-D motherboard and want to use w83792d driver under linux-2.4, if they
> have to write the value "0x08" into "0x04b9" by themselves each time.

After talking with Jean we agreed on this:

I'm sorry there is no easy way to fix this. We consider this as BIOS bug
and it should be fixed by ASUS. If companies  use "enterprise 2.4 linux"
I hope they will complain about this and ASUS removes such stupid
restriction. Userspace possibilty is left for such users. Their discomfort
is ASUS fault.

My offer:

Maybe you should ask ASUS to give you full list of motherboards that are
hiding your chips (and of course how to unlock them). I'm willing to
implement quirks.c for 2.6 kernels but thats all I could do for you.

My oppinion, but I think others will agree on this too:

I'm sorry, we strongly belive that this practices are just putting
obstacles to our work. I know people werent happy with their proprietary
ASMA software under Linux. Maybe thats the reason you are writing the
driver for lm_sensors infarstructure.

Moreover more obstacles are set:

1) Chips docs under NDA
2) Bus chips under NDA
3) Hide and seek games with ASUS
4) Motherboard manufactures refusing to tell us what formulas they use.
   (they want NDA, or simply do not respond)

Please help us to change this practice! I can't get why they are doing
such things. We are simply working on support of their motherboards for
free and they dont get it!!!

Regards

Rudolf
