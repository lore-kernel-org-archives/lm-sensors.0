From: david@ad5ey.net (David Holl)
Date: Tue, 02 Jan 2007 18:46:55 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <6b59d5890701021046g4ced9ebk64ed2f33447a776e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 12/26/06, Hamlet <hamletmun at fibertel.com.ar> wrote:
>
> ...
> But "sensors" command doesn't show any value.
> It just says the chipset:
>
> w83627dhg-isa-0290
> Adapter: ISA adapter
>
> Do I have to update lm-sensors package?
> I am using 2.10.0 version
>

Hey Hamlet, I noticed the same thing too about "sensors" not reporting
w83627dhg values, so I submitted a patch which should be included in the
next lm-sensors release:
http://www.lm-sensors.org/ticket/2157

If you can, try compiling the lm-sensors code from the subversion
repository:
http://www.lm-sensors.org/wiki/Download

I think the largest thing I missed in my patch was an example for
sensors.conf for our "Asus P5B Deluxe WiFi AP" motherboard, largely because
I haven't had time to work out the voltage scalings.  (I was more concerned
for the fan speeds.)

In Gentoo, the newer gkrellm version (2.2.10) seems to properly support
libsensors & sensors.conf with the lm_sensors USE-flag.  (I unmasked the
latest gkrellm with echo "=app-admin/gkrellm-2.2.10 ~x86" >>
/etc/portage/package.keywords)

- David Holl
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070102/3cd89a9e/attachment.html 
