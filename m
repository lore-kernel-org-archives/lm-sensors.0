From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 29 Jun 2015 11:27:39 +0000
Subject: Re: [lm-sensors] Does anyone have a driver for the MAX31790?
Message-Id: <20150629132739.2137bb2e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADrkgWK9en4v3QpobCVDeY0GqCMach-nPPJ1fiNk6uXv-4EHYA@mail.gmail.com>
In-Reply-To: <CADrkgWK9en4v3QpobCVDeY0GqCMach-nPPJ1fiNk6uXv-4EHYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please don't top-post.

On Mon, 29 Jun 2015 19:33:45 +0900, Il Han wrote:
> Thank you very much for your answer.
> 
> Isn't there any similar chip to MAX31790?

Not that I know of.

> There are drivers for max1111, max16065, max1619, max1668, max197, max6636,
> max6642, max6650, max6697 in the Linux Kernel Archives.
> What is the most similar chip of these?

None.

> Is the MAX31790 a completely new chip?

Yes, it doesn't look like anything we support at the moment, so a brand
new drivers would have to be written.

I've added the MAX31790 chip to the Devices list in the wiki, with a
link to your request.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
