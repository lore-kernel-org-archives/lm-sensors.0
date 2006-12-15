From: kernel@kolivas.org (Con Kolivas)
Date: Fri, 15 Dec 2006 05:14:52 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <200612151614.52853.kernel@kolivas.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 15 December 2006 14:34, David Hubbard wrote:
> Hi Colin,
>
> Thanks for doing that! I have attached a similar patch I submitted for
> review 4 days ago. Jean is on vacation right now and will probably
> look at both patches when he gets back. (I don't know exactly when
> that is.) How would you feel about downloading and testing the patch I
> have. One of the significant improvements is that it only reports 9
> voltage inputs, where your patch reports 10. The 627DHG only has 9
> inputs. In the patch I'm sending you, there's an update to
> linux/Documentation/hwmon/w83627ehf, which describes a lot of the
> relevant information about the 627DHG.
>
> Anyway, I'd love to work with you to get 627DHG support in the kernel.

Oh mine was never meant to be comprehensive, just a hack as I needed to see 
the cpu temp. From the looks of your patch it doesn't appear that you need my 
help anyway :) Thanks for the effort.

-- 
-ck

