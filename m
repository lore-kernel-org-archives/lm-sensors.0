From: zdavatz@ywesee.com (Zeno Davatz)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Gnome hangs after sensors installation
Message-Id: <BB4EED69.6D58%zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BB4EE262.6D4C%zdavatz@ywesee.com>
In-Reply-To: <BB4EE262.6D4C%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 31.7.2003 15:45, "Jean Delvare" <khali@linux-fr.org> wrote:

> Ah OK, it's different from what I had first thought.
Yes I am quite happy about that too...

> 
> It means that you forgot to run "ldconfig" after installing. (Before
> doing that, you may have to add the line "/usr/local/lib" to
> /etc/ld.so.conf, if it's not already there).
Ok, done that.

> Oh, great. It's less awful than I first feared.
> 
>> Where do I have to look for the startup script of lm-sensors? In
>> /etc/rc.d?
> 
> If sensors-detect did not finished its installation, then the startup
> script is probably not installed. Just check in /etc/sysconfig if you
> can see any "lm_sensors" file. If there is one, delete it.
I do not have a /etc/sysconfig...

Any other place I could look? Gnome still hangs at boot with the error I
mailed you...

> 
> Maybe there's a script brought by your distribution itself. You should
> look for it in /etc/rc.d. The exact location depends on the
> distribution, so I can't tell.
I do not habe /etc/rc.d
I have /etc/rc0.d till rc7.d
> 
> Why Gnome doesn't start anymore, that I can't say. Do you have any
> hardware monitoring application? (Gkrellm maybe?) Maybe it's trying to
> load some modules and fails.

I could run sensors-detect now till the end. What I find strange is, that I
do not find any sensors. When I done sensors-detect with the Debian packages
I found the sensors but I could not run 'sensors' as there is no
'lm-sensors' package for Debian PPC; there are only the source packages.

My computer still hangs when starting Gnome, also some other settings seem
messed up.

Thanks for further Feedback.

Zeno

-- 
Mit freundlichen Gr?ssen / best regards

Zeno Davatz
Strategie & Akquisition

+41 1 350 85 86

www.ywesee.com > intellectual capital connected > www.generika.cc


