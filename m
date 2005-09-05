From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 05 Sep 2005 22:51:45 +0000
Subject: [lm-sensors] Call for 2.9.2
Message-Id: <20050905225142.771685e7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050716170208.7c1f7e3d.khali@linux-fr.org>
In-Reply-To: <20050716170208.7c1f7e3d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> * Jean Delvare <khali@linux-fr.org> [2005-08-31 11:30:23 +0200]:
> > I have been thinking of it, and came to the conclusion that it was
> > merely a documentation issue.  I was planning to add en entry in the
> > FAQ, a news item on our website when we release, and a note to
> > kernel26.html.  Don't you think it is sufficient?  What do you
> > suggest?  I would like to avoid adding temporary code to libsensors
> > if possible, as we will ultimately drop non-hwmon support anyway.
> 
> I don't think just documenting it is enough.  Here is an example
> scenario that better demonstrates the present "surprising" behavior:
> 
> (with just i2c-i801 and eeprom modules loaded using Linux
> 2.6.12-rc6-mm2)
> 
> # sensors
> 
> (shows eeprom info)
> 
> # modprobe lm78
> 
> # sensors
> 
> (shows lm78 info but *not* eeprom info)

I can reproduce that too, of course.

> I know you don't want a lot of temporary code shoved in there, and for
> that  matter neither do I.  So here is a minimal patch.  It simply
> disables eeprom display for all 2.6.x kernels.  We can rip out the
> guts of the eeprom code for the next release - my libsysfs patchset in
> progress already does some of that anyway.
> 
> This should be easier to document and may also generate fewer bug
> reports.

Agreed. There are minor problems though.

1* Your minimal hack leaves dead code in libsensors. It's probably not
much of a problem, as long as we don't forget to remove it right after
the release.

2* Eeproms are not the only affected chips. "sensors" displays empty
entries for all i2c chips that have a driver. This includes the adv7176
and saa7110 video devices for me. They too will disappear when one loads
any hwmon driver. It should cause less surprise than for eeprom, because
no useful information is displayed, but it might still confuse the
users. I have no immediate solution though.

Feel free to commit your patch BTW, it looks good.

Thanks,
-- 
Jean Delvare
