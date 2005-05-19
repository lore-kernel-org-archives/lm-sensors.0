From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: RFC PATCH update via686a DIV_TO_REG to return error
Message-Id: <KaIr6wSz.1111397729.7608500.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <djas31ljne3adsttsb6819i1ijeut47js2@4ax.com>
In-Reply-To: <djas31ljne3adsttsb6819i1ijeut47js2@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> Old behaviour: accept fan_div - 1, 2, 4 or 8; default 2
>
> This changes DIV_TO_REG to instead report an error when user-space
> try set invalid fan divisor.

Right, that's how we would like our drivers to behave.

> Queries
> I'm demonstrating a method to keep scaling / valid numbers up near
> top of source with similar stuff.  Not sure if it needed or wanted?

I don't think it is needed. It makes sense for conversions that cannot
fail, as it makes the code more readable. But here, this is real code,
called only once, so I would keep it in the parent function. Seems more
readable to me, and more efficient as well (the way you did it adds a
comparison and a local variable in the parent function.)

> Adjust fan limits required?

It's not required, in that your patch already does something we want per
se; but definitely welcome, for example as a patch to apply after this
one.

> @@ -510,9 +521,15 @@
>  		size_t count, int nr) {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct via686a_data *data = i2c_get_clientdata(client);
> -	int val = simple_strtol(buf, NULL, 10);
> +	int tmp, val = simple_strtol(buf, NULL, 10);

Please don't name it "tmp". By nature, all local variables are
temporary, so such a name doesn't help. That being said, there won't
be no more variable needed if you merge DIV_TO_REG in there, so that's
another way to solve the problem ;)

> +	if ((tmp = DIV_TO_REG(val)) < 0) {
> +		dev_err(&client->dev, "fan_div value %d not supported. "
> +				"Choose one of " DIV_VALID_NR "!\n", val);

Strange indentation.

>+		 return -EINVAL;

Ditto.

Thanks,
--
Jean Delvare
