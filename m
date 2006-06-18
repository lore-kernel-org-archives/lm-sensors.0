From: gimeshell@web.de (gimeshell at web.de)
Date: Sun, 18 Jun 2006 15:15:46 +0000
Subject: [lm-sensors] better temp2 computation for asus CUSL2C
Message-Id: <20060618171546.f1242303.gimeshell@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060618021736.f08a39bb.gimeshell@web.de>
In-Reply-To: <20060618021736.f08a39bb.gimeshell@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 18 Jun 2006 11:31:17 +0200
Jean Delvare <khali at linux-fr.org> wrote:

> > But resulting temperature is about 8 degrees too low.
> 
> Compared to what?
> 
> http://www.lm-sensors.org/wiki/FAQ/Chapter3#MyBIOSreportsamuchhigherCPUtemperaturethanyourmodules
> (In particular the last paragraph.)
> 

Yes that's it!
Now what would be better way to correct this? Is there any difference
between both ways?

a) multiply @ with bigger factor eg 31 instead of 30
compute temp2 (@*31/43)+25, ...

b) adding bigger factor, eg 31 instead of 25 to @.
compute temp2 (@*30/43)+31, ...

Why isn't compute line so easy to only add ONE value to @. No
multiplikation anymore. Only addition. Is this a practical thought?

regards,
gimeshell

