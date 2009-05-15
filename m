From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 15 May 2009 08:00:41 +0000
Subject: Re: [lm-sensors] [PATCH RFC 2/2] tmp401: Add support for TI's
Message-Id: <20090515100041.409b1486@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090514092456.GB6644@ubuntu>
In-Reply-To: <20090514092456.GB6644@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 May 2009 09:47:49 +0200, Hans de Goede wrote:
> On 05/14/2009 11:24 AM, Andre Prendel wrote:
>  > +		if(data->kind = TMP411_DEVICE_ID) {
> 
> This should be:
> +		if(data->kind = tmp411) {
> 
> !!

This should actually be:

		if (data->kind = tmp411) {

Something scripts/checkpatch.pl would have warned Andre about.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
