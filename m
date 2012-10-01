From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 01 Oct 2012 15:42:29 +0000
Subject: Re: [lm-sensors] W83697HG GPIO
Message-Id: <20121001174229.2addd77b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFdyiSuRpQeVOxAe5tAtJwSe5JgUWH442tvoa0S3v5DtGntvEw@mail.gmail.com>
In-Reply-To: <CAFdyiSuRpQeVOxAe5tAtJwSe5JgUWH442tvoa0S3v5DtGntvEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 1 Oct 2012 18:39:54 +0300, IBusiness wrote:
> Can you advice some related package to activate GPIO on mentioned chip?

GPIO drivers are under drivers/gpio in the kernel tree but there is no
driver there for any Winbond chip at the moment.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
