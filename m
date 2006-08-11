From: dave@boost-consulting.com (David Abrahams)
Date: Fri, 11 Aug 2006 17:01:37 +0000
Subject: [lm-sensors] Thinkpads still not supported?
Message-Id: <u7j1f1a1a.fsf@boost-consulting.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20060811T155741-190@post.gmane.org>
In-Reply-To: <loom.20060811T155741-190@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare <khali at linux-fr.org> writes:

> Hi David,
>
>> I see my model (T60p) in
>> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-April/015983.html
>> Does that mean anything, or is
>> http://www.lm-sensors.org/browser/lm-sensors/trunk/README.thinkpad still the
>> latest news?
>
> It's completely unrelated. The hdaps driver reports the acceleration of
> the laptop. It's meant to park the hard disk driver heads if the laptop
> falls, for example. It will work on your laptop. But it's not a
> hardware monitoring chip in the common sense of the term.
>
> The SMBus is still blacklisted on IBM systems based on a PIIX4 chip.
> Your laptop probably has a more recent chip (Intel 82801), but anyway
> we've never seen a Thinkpad with a useable hardware monitoring chip as
> far as I remember, so it's probably not worth investigating. If you
> want to know the temperature laptop, try the "thermal" acpi driver
> instead.

Thanks.  I think I may already have that.  "acpi -t" does display two
thermal zones.  Somehow my gnome-sensors applet is also getting a
reading for the GPU (in a category called "ibm-acpi"), which is
alarmingly high.

What I'm really after is much more at the application level; something
like "ksensors", which can help me keep the laptop running optimally
for whatever situation I'm in, and will let me switch between profiles
easily if I want battery life, performance, or etc.  However, the
ksensor package depends on lm-sensors, which according to that page
might be doing terrible things to my BIOS (any chance _that's_
outdated info?)  I already had ksensors installed, and it seemed to be
working OK, but took it out when I read that.

-- 
Dave Abrahams
Boost Consulting
www.boost-consulting.com


