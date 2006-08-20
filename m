From: jim.cromie@gmail.com (jim.cromie at gmail.com)
Date: Sun, 20 Aug 2006 21:49:43 +0000
Subject: [lm-sensors] [RFC][PATCH] hwmon:fix sparse warnings + error
Message-Id: <44E8D8F7.5090000@yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44E8C9AE.3060307@gmail.com>
In-Reply-To: <44E8C9AE.3060307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, Mark Studebaker <mdsxyz123@yahoo.com>, lm-sensors@lm-sensors.org, LKML <linux-kernel@vger.kernel.org>

Michal Piotrowski wrote:
> Hi,
>
> This patch fixes 56 sparse "ignoring return value of 'device_create_file'" warnings. It also adds error handling.
>
> w83627hf.c |   96 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------
> 1 file changed, 80 insertions(+), 16 deletions(-)
>
> Regards,
> Michal
>
>   

Ouch.

Ideally, you should have checked here (LM-Sensors ML) 1st.
The driver you chose has already been reworked along those lines,
and accepted by Jean Delvare, and thus slated for .19

an early copy (8/02)
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-August/017043.html

If youre so inclined, there are ~38 others in need
of similar attention ;)



<cp-pasted from ML thread>
Here is asb100.c... I'll add lm75, lm78, smsc47b397, and w83627hf
to this patch as I have time.  (Jean: don't apply yet.)

pc87360 (one of the larger offenders) is also now fixed.


Im sure if you ask nicely, Jean will provide you with
a current/authoritative list ;-)


http://khali.linux-fr.org/devel/i2c/linux-2.6/?M=A
has a fairly current collection and series-file (8/14/06)
Unfortunately, the series doesnt enumerate the patches
as a set, and several accepted patches arent there yet.
Jean, is this still the best/good place to keep current ?


