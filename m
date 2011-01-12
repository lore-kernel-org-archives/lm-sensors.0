From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 12 Jan 2011 14:30:26 +0000
Subject: Re: [lm-sensors] Erratic value of MCH temp. (0C),
Message-Id: <AANLkTimDAi_Hicp2O79_GzK2g87iZWRg5vHdN3F-yRYJ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294052867.1860.36.camel@Asus5>
In-Reply-To: <1294052867.1860.36.camel@Asus5>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 12, 2011 at 3:15 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Wed, 12 Jan 2011 15:03:31 +0100, Luca Tettamanti wrote:
>> It might make sense to let the user override the labels, Jean what do you think?
>
> It is already possible. Driver-provided labels are only a hint and a
> bonus, it is still possible to specify labels in the traditional way
> with a sensors3.conf file, for example:
[cut]

Ah, of course :) I was thinking about overwriting directly the sysfs
entry, but it's unnecessary.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
