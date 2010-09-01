From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 01 Sep 2010 15:52:03 +0000
Subject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <20100901155203.GB13637@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <929339.59525.qm@web50002.mail.re2.yahoo.com>
In-Reply-To: <929339.59525.qm@web50002.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 01, 2010 at 10:58:47AM -0400, Mahmood Naderan wrote:
> >The current text is quite absolute ("Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors")
> >and really invites users to overwrite the distribution specific scripts.
> 
> I really did that. See:
> 
[...]

> Do you confirm that? What should I do in order to remove lm-sensor and reinstall it again?
> 
Try

	sudo aptitude reinstall lm-sensors

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
