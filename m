From: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
Date: Mon, 29 Mar 2010 19:58:40 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: sht15: Fix sht15_calc_temp
Message-Id: <703813817.3661269892720121.JavaMail.root@mail.savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1269639013-26029-1-git-send-email-jerome.oufella@savoirfairelinux.com>
In-Reply-To: <1269639013-26029-1-git-send-email-jerome.oufella@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- "Jonathan Cameron" <jic23@cam.ac.uk> wrote :
> If it works it is fine with me, but please add some documentation so
> that any
> one coming to the code in the future can understand why you aren't
> using
> what the datasheet lists.
> 
> Given it would be useful to provide everything you have listed here,
> I'd
> be inclined to add a file in Documentation/hwmon supported by a
> comment inline
> with the code.  If you have any details on date of manufacture of the
> part you
> tested etc or any comments from the manufacturer it would be useful to
> put
> those in as well.
> 
> Jonathan

Hi Jonathan,

In fact, the new function is doing what the datasheet says,
the function used to interpolate the corresponding value between two
of those reference points being left to the programmer's discretion.

In the current version of sht15_calc_temp(), the interpolation that was
done was being broken because of fixed point divisions that messed
the things up. In fact, the temperatures returned so far were wrong.

So after different tries on trying to improve the current function's 
precision, I ended up getting better results with a different approach
with a proportional factor based linear interpolation.

The manufacturer data remains valid, unchanged, and respected.

Jerome




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
