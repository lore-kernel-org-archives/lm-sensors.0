From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Tue, 17 Apr 2007 16:54:18 +0000
Subject: Re: [lm-sensors] w83627dhg msi 975x problems
Message-Id: <4dfa50520704170954q4baf9564je17a958a8397923c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070415185853.GA11766@xeron.cc>
In-Reply-To: <20070415185853.GA11766@xeron.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Jordan,

> That's really strange. The dumps will tell us more though.

Jordan, be sure to reboot your machine and *not* load the w83627ehf driver.

> If these modes were in use, pwmN_enable would be 3 or more if I
> remember correctly. David knows the code better and should be able to
> confirm that. So it really looks like it's not what your system uses.

Correct. pwmN_enable = 2 would mean SmartFan I mode, but 2 or higher
would mean automatic control by the w83627dhg chip. However, using
PECI, the fan control could be done in ACPI (yuck) or possibly in the
ICH7.

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
