From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: adm1026 driver port for kernel 2.6.10-rc2 (patch includes driver,
Message-Id: <20041124213600.GA3165@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041102221745.GB18020@penguincomputing.com> <NN38qQl1.1099468908.1237810.khali@gcu.info> <20041103164354.GB20465@penguincomputing.com> <20041118185612.GA20728@penguincomputing.com> <20041123165236.GA4936@penguincomputing.com>
In-Reply-To: <20041123165236.GA4936@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: phil@netroedge.com, khali@linux-fr.org, sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org

Hm, this looks like a bug:

> +static ssize_t set_pwm_enable(struct device *dev, const char *buf,
> +		size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adm1026_data *data = i2c_get_clientdata(client);
> +	int     val;
> +	int     old_enable;
> +
> +	if ((val >= 0) && (val < 3)) {

You are using val before assigning it anything.  The compiler warns you
about this issue.

Care to fix this up and resend the whole patch?

Oh, and it should be "Signed-off-by:" not "Signed off by:" like you had
used :)

thanks,

greg k-h
