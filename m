From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 27 Sep 2007 14:42:49 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20070927164249.0d1f68b7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Wed, 26 Sep 2007 23:02:31 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > As announced last week, I released a first release candidate (rc1) of
> > lm-sensors 3.0.0. The API is supposedly OK now, so it's time for
> > application authors to try and port their applications to the new
> > library and send us feedback.
> (...)
> Excellent work Jean! I've given this a test run on all my systems / test rigs 
> and it works great everywhere. I'll create patches for ksensors, gkrellm, and 
> gome's sensors-applet as time permits. I'm afraid this will take a while as 
> currently I'm very busy with stuff regarding the upcoming Fedora 8.

Great, thanks for the testing and thanks for working on application
patches. I'll try to take care about ksysguard myself, but I don't have
much time for this right now. net-snmp will have to be ported too. 

> Talking about Fedora as soon as the development branch gets unfrozen for the 
> F-9 cycle I'll put this new lmsensors in Fedora's development branch (together 
> with patches apps), so that it can get a good amount of testing there, this 
> won't happen for a while though.

Same for me, I'm waiting for openSuse 10.3 to be out before I start
packaging the new lm-sensors and i2c-tools for the next version.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
