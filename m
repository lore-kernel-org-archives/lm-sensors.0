From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: temperature monitor on my w83627hf-isa-0290
Message-Id: <427C8325.70405@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.61.0505062352260.4119@c-24-130-248-54.hsd1.ca.comcast.net>
In-Reply-To: <Pine.LNX.4.61.0505062352260.4119@c-24-130-248-54.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

chekov@alum.wpi.edu wrote:
> I have an ABIT AG8 motherboard which uses a Winbond W83627HF-AW chip for
> I/O (other MB specs at: http://www.mbreview.com/ag8.php).
> I am running Fedora Core to patched to kernel 2.6.10-1.771_FC2smp with
> lm_sensors 2.9.1 installed

Hi,

You have there uGuru chip haven't you?

We are sorry, abit refuses to release the docs. Complain and blame ABIT.
As for the FANs you can try to change the fan divisor to 4 or 8.
(you just need to set fanX_div 4 in config file)
But I think FANs are connected to uGuru too.

So bad luck. If you have good friends at ABIT try them. It is very very dificult
to support unknown chips and we dont have much time/interrest to support them
right now.

If you have any further questions just ask.

Regards

Rudolf

