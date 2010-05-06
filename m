From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 06 May 2010 19:23:08 +0000
Subject: Re: [lm-sensors] asus_atk0110 Not Activated in lm_sensors-3.1.1-3
Message-Id: <t2n68676e01005061223sd5c2ff0eje7690164cbb673de@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <s2p68676e01004280524w93c9234az452c4e30ac73e392@mail.gmail.com>
In-Reply-To: <s2p68676e01004280524w93c9234az452c4e30ac73e392@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Wed, May 5, 2010 at 4:48 AM, Marc <digitelp@yahoo.com> wrote:
> Thanks for the advice Jeff...  But it didn't work. I updated all the software,
> including a new sensors_detect and such and still the exact same results
> as I described.  retried various things and no luck at all!

Enable HWMON_DEBUG_CHIP and recompile asus_atk0110 if you can; also
send me a copy of the DSDT.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
