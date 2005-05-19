From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: New chip driver development plan to Lm_sensors
Message-Id: <20050104051340.GI17759@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <E36E0C5C92D97049B4855B5498A94547F5124B@weshml02.winbond.com.tw>
In-Reply-To: <E36E0C5C92D97049B4855B5498A94547F5124B@weshml02.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunhao:

(I wrote:)
> > > Now for my own question to you: I have a w83791sd on my mainboard.
> > > Will you publish a better datasheet for that one?  The datasheet that
> > > is currently available on your website doesn't have enough info to
> > > create a driver.

* Huang0@Winbond.com.tw <Huang0@Winbond.com.tw> [2004-12-24 13:07:42 +0800]:
> > As to this question, I have asked the help of my manager, he will give
> > me the answer in the near future, then I will send mail to you.
> > Would you please tell me the version number of your available
> > w83791sd data sheet? So that we can know whether it has been updated.
> 
> The attached data sheet is for you, I get it this morning, it is said
> to be up to date.
> I wonder whether it can provide the information you need.

Thanks.  I don't think I'll write a driver for it (I don't personally
need one) but that datasheet is more useful than the previous one.

In case you're wondering, I wanted to see if this device supported any
SMBus block transactions (as a way for me to test a *bus* driver).  I
guess not though... oh well.

Thanks and regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
