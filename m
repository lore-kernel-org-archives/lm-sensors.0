From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 24 Jul 2007 20:09:31 +0000
Subject: [lm-sensors] lm78 platform driver conversion breaks certain lm78
Message-Id: <46A65C7B.6030905@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Please go here:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id$9428

For the full story. I think this is caused by this patch:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019227.html

Where you not only converted it to a platform driver but also made the 
detection more stringent (shouldn't that have been a seperate patch?).

I'll be working with the reporter to see whats up, but since you are the expert 
your input would be valued very much. I think the easiest would be if you could 
join the discussion in Fedora's bugzilla. Setting up an account is a breeze.

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
