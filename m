From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 25 Jun 2009 08:06:05 +0000
Subject: Re: [lm-sensors] hwmon-vid driver from linux 2.6.29
Message-Id: <20090625100605.3435b331@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A0C6BF7.9010107@assembler.cz>
In-Reply-To: <4A0C6BF7.9010107@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hleb,

On Wed, 24 Jun 2009 20:47:44 +0300, Hleb Valoshka wrote:
> On 6/8/09, Jean Delvare <khali@linux-fr.org> wrote:
> >> > You could contact the motherboard vendor and tell them about the
> >> > problem (the question is "Is VID5 properly routed from CPU to
> >> > IT8716F?") and see what they have to say about this.
> >> The question is sent.
> > OK, thanks. Please let us know if you manage to get something useful.
> 
> They have replied.
> 
> => All voltages and monitoring is properly routed in our m/b's. If you
> use old s/w with Phenom CPU, it will not be monitored properly in some
> points by 3rd party s/w. We recommend you to use s/w for Windows,
> because we don't have s/w for your OS.
> =
Thanks for transmitting the information. Their vague warning about the
Phenom doesn't apply to your case as you have a 0Fh family, not 10h
family CPU. Not that it would be terribly useful anyway, as they do not
say _why_ 3rd party software could get it wrong. And they did not
specifically answered to the question we asked about VID5.

Our testing was pretty clear that the value of VID5 was not correct. If
they can't explain that then I fear they won't be of any help to us :(

As you may have seen, I have posted a patch meanwhile, which should
work around the problem on your board and possibly others. Did you have
the opportunity to test it?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
