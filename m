From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 17 Dec 2006 09:55:45 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20061217105545.0c373f0e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David, Con,

On Thu, 14 Dec 2006 20:34:13 -0700, David Hubbard wrote:
> Thanks for doing that! I have attached a similar patch I submitted for
> review 4 days ago. Jean is on vacation right now and will probably
> look at both patches when he gets back. (I don't know exactly when
> that is.) How would you feel about downloading and testing the patch I
> have. One of the significant improvements is that it only reports 9
> voltage inputs, where your patch reports 10. The 627DHG only has 9
> inputs. In the patch I'm sending you, there's an update to
> linux/Documentation/hwmon/w83627ehf, which describes a lot of the
> relevant information about the 627DHG.

No, I wasn't on vacation, I was away from home for my work. I will be
in vacation later this month (as pretty much everyone, I guess.)

I don't know when I'll have time to review your patch, as I am
currently busy with large i2c-core cleanups, and am also spending a
log of time preparing a talk I am giving by the end of January (a
significant part of that time being needed to just tame OpenOffice
Impress). Rudolf Marek might be quicker than me on this one.

Thanks,
-- 
Jean Delvare

