From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Nov 2007 14:40:10 +0000
Subject: Re: [lm-sensors] how to create rpm for lm_sensors-2.10.5
Message-Id: <20071109154010.6ada97a6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <941005.10298.qm@web56302.mail.re3.yahoo.com>
In-Reply-To: <941005.10298.qm@web56302.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 7 Nov 2007 16:54:57 -0500 (EST), PoWah Wong wrote:
> I use FC6 for a couple of computers, so I want to
> create one rpm for lm_sensors-2.10.5 and install it
> for all computers.
> How to create rpm for lm_sensors-2.10.5?
> 
> This is a workaround, isn't it?
> "make package" will create lm_sensors-2.10.5.tar.gz,
> scp it to all computers, untar it, then do "make
> user_install".

atrpms.net has lm_sensors rpm packages ready for Red Hat and Fedora,
just pick them:
http://atrpms.net/name/lm_sensors/

OpenSuse also has lm_sensors packaged:
http://software.opensuse.org/search?p=1&q=sensors&baseproject=openSUSE%3A10.3

If you need a RPM for another distribution, you can try to adapt the
RPM .spec file that come with one of the source rpm packages above to
your own needs.

>       Be smarter than spam. See how smart SpamGuard is at giving
> junk email the boot with the All-new Yahoo! Mail.  Click on Options
> in Mail and switch to New Mail today or register for free at
> http://mail.yahoo.ca 

How nice. A spam advising how to get rid of spam. Being "smarter than
spam" could include banning yahoo from our mailing lists to prevent such
abuse in the future.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
