From: Marc Titinger <mtitinger@baylibre.com>
Date: Thu, 29 Oct 2015 08:52:10 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: ina2xx: convert driver to using regmap
Message-Id: <5631DE3A.90002@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1446030293-12869-1-git-send-email-mtitinger@baylibre.com>
In-Reply-To: <1446030293-12869-1-git-send-email-mtitinger@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 29/10/2015 05:56, Guenter Roeck wrote:
> On Wed, Oct 28, 2015 at 12:04:53PM +0100, Marc Titinger wrote:
>> Any sysfs "show" read access from the client app will result in reading
>> all registers (8 with ina226). Depending on the host this can limit the
>> best achievable read rate.
>>
>> This changeset allows for individual register accesses through regmap.
>>
>> Tested with BeagleBone Black (Baylibre-ACME) and ina226.
>>
>> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
>
> Both patches applied to -next.

Cool, thanks.
>
> I noticed that the 'kind' variable is unnecessary.
> If you have time, it would be great if you can send me a patch removing it.
>
No problem, on the way!

M.

> Thanks,
> Guenter
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
