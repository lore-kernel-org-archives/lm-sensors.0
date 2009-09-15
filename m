From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 15 Sep 2009 13:35:27 +0000
Subject: Re: [lm-sensors] unhide_ICH_SMBus: line 33:
Message-Id: <68676e00909150635i47ead85fo5fa706a5ece9d6e8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9122E1.7010006@ribosome.natur.cuni.cz>
In-Reply-To: <4A9122E1.7010006@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 15, 2009 at 3:27 PM, Jean Delvare <khali@linux-fr.org> wrote:
> And there are also a number of drivers dedicated to Asus systems, such
> as asus_atk0110, asus-laptop and asus_acpi. You should try them if you
> haven't already.

I never saw a laptop with the ATK0110 hwmon interface; the other two
are for back light, leds, special keys.
As Jean suggested you should try the thermal driver which should work
(I have a L3D and it works).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
