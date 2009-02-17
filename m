From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 17 Feb 2009 19:52:07 +0000
Subject: Re: [lm-sensors] Does lm-sensors support chassis intrusion for
Message-Id: <20090217205207.4e956073@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <f188924b0902150713q43addf9g94851a4d581b411e@mail.gmail.com>
In-Reply-To: <f188924b0902150713q43addf9g94851a4d581b411e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

On Tue, 17 Feb 2009 08:08:04 -0500, Michael Hampton wrote:
> I'm also interested in chassis intrusion (not to mention having my
> Winbond W83667HG chip fully supported in hwmon.c; see my previous
> message to the list on that topic). I'd like to contribute, but I admit

I have reviewed the patch adding support for the W83667HG chip, and had
some objections. It's now up to the patch author to answer them and
submit a new patch...

> I'm better at coding a standard than designing one. What does this
> standard need to look like?

Basically, a new entry in Documentation/hwmon/sysfs-interface. An entry
in this file consists in:
* A file name, wisely chosen to fit in the rest of the interface, be
  non-ambiguous and allow for future extensions. I can't think of any
  obvious extension in the case of the chassis intrusion detection, but
  it doesn't hurt to think about it for a moment. For example, could
  there be chips with more than one chassis intrusion detection sensor?
* Possible values for that file, with their meaning.
* Whether this file can be written to, what should be written and what
  happens when you do.

Looking at how some drivers implemented it in the absence of a standard
(as far as I can see: adm9240, w83792d and w83793) may provide
interesting suggestions. Looking at other chips which support the
feature even though their driver doesn't yet may be useful as well.

I can add you to the Cc list of ticket #2370 if you want.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
