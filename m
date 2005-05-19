From: herbert@mamute.net (Herbert G. Fischer)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: No sensors found
Message-Id: <001401c43069$3afff9d0$0100000a@volcano>
List-Id: <lm-sensors.vger.kernel.org>
References: <000801c43068$c801a6e0$0100000a@volcano>
In-Reply-To: <000801c43068$c801a6e0$0100000a@volcano>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry... I apologise...

I found a tip on kernel 2.6 info to unload i2c-viapro and use i2c-isa with
via686a
and now it worked.

Thanks for this great software!

----- Original Message ----- 
From: "Herbert G. Fischer" <herbert@mamute.net>
To: <sensors@stimpy.netroedge.com>
Sent: Sunday, May 02, 2004 2:13 PM
Subject: No sensors found


> Hi,
>
> I'm having problem to get sensors from a Soyo K7VTA Pro motherboard.
> Attached are the output from the commands of "5.1 What to send us when
> asking for help".
> Attached is the config of my kernel too.
>
> The kernel is 2.6.5, lm_sensors 2.8.6.
>
> Thanks in advance,
>
> Herbert G. Fischer
>
