From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Dec 2007 20:42:39 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: No longer depend on libsysfs
Message-Id: <20071202214239.04635e5a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071129120153.26879145@hyperion.delvare>
In-Reply-To: <20071129120153.26879145@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 02 Dec 2007 20:39:27 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > If you have the possibility to test the patch, that would be
> > appreciated as well, and less time-consuming than a review. Different
> > kernel versions and configurations can make the sysfs tree look a bit
> > different. Also, i2c and non-i2c chips have different code paths. I've
> > tested as much as I could on my systems, but more testing can't hurt.
> 
> I've just given it a test run on my abituguru machine, works fine. Tomorrow 
> I'll give it a test run on a FSC machine.

OK, thanks.

> If you're reasonably sure this patch is ok, I could put it in the Fedora 
> Rawhide / devel package for some greater exposure, then we can be pretty sure 
> there will be plenty of testing before we release 3.0.1 .

Well, I have no reason to believe that anything is wrong with this
patch, as all my testing has been successful. Feel free to apply it to
Rawhide if you want. I would like to commit the change soon, the only
thing I am waiting for at the moment is Mark's ack, as we had been
discussing the matter before, he might want to comment on the approach
I took in my patch.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
