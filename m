From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 01 Nov 2005 23:57:00 +0000
Subject: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE 2.6
Message-Id: <4367F2B8.7040907@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051012133202.9303523324@box1.planbit.co.uk>
In-Reply-To: <20051012133202.9303523324@box1.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>+**     in the 2.6.14 kernel source to create this code.
>>+**     VRM doesn't work on the Via Epia 5000 that I have as the kernel
> 
> call
> 
>>+**	   vid_which_vrm() returns -1.  Apparently the Via CPU is
> 
> unrecognised....
> 
> The vid_which_vrm issue is interesting. Rudolf, can you please look
> into it?
> 

Yes,

This is not yet in our detection table. Here is what we know:

TYPE  FAMILY  MODEL  STEPPING
0       6       7       0+   something special EDEN ESP samuel 2
0       6       7       8+   VRM85 C3 EZRA
0       6       8       0-7  VRM85 C3 EZRA T
0       6       9       0+   VRM85 NEMIAH
0       6       9       8+  max1718 C3-M

max1718 => Notebook CPU Step-Down Controller for Intel
 Mobile Voltage Positioning (IMVP-II)

http://www.egevo.se/dokument/max1718.pdf
http://www.maxim-ic.com/products/power_supplies/imvp.cfm

VID "something special"
1 1 1 1  1.30V
1 1 1 0  1.35V
0 0 0 0  2.05V


We need to define 2 new VIDs one is something called

IMVP-II (I dont know anything about -I and -III  => will call it 1718

and the that really strange samuel 2 VID codding. => will call it 670

Ideas? Questions?
If not I will develop the patch.

Regards
Rudolf
