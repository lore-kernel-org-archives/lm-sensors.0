From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 05 Mar 2006 09:52:18 +0000
Subject: [lm-sensors] [PATCH] Add fan control support to W83627EHF
Message-Id: <440AB4D2.4020806@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409FFA1.7050109@sh.cvut.cz>
In-Reply-To: <4409FFA1.7050109@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David Hubbard wrote:
> Hi Rudolf,
> I disagree. If users want to ignore the RPM cruise or speed cruise
> then it's easy to modify the sensors.conf to suit their taste. I agree
> that there isn't a standardized sysfs file for the target RPM, but I
> am planning on using the RPM cruise feature. Yuan has already
> implemented it. I don't think it'd be a problem to support it. Since
> it is present on all four PWM outputs, and Smart Fan 3 isn't, I
> thought it would make sense to have PWM cruise be mode 3.
> 

Well it could be implemented when you will create some files like fanX_target
(Because this file has to be in RPM and you need to convert the RPM into ticks and
write it back to the "target temp" register. On the other hand it will mean that
user receive nonsence when reading from tempX_target

I think I'm missing the whole point of RPM cruise. To me it seems I can
manually setup the requested RPM through the pwm file in manual mode.

Can you explain please how the RPM cruise mode is different from that?

Please always CC to the list so others know too ;)

Thanks,
Regards
Rudolf

