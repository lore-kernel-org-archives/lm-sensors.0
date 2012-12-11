From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Dec 2012 09:57:53 +0000
Subject: Re: [lm-sensors] Driver for Bulldozer
Message-Id: <20121211105753.2d7eca13@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAMcsHH20xPDkTq7+9KyxDodnNYKB+UNS3_T=Exfq=BfP+kaxjw@mail.gmail.com>
In-Reply-To: <CAMcsHH20xPDkTq7+9KyxDodnNYKB+UNS3_T=Exfq=BfP+kaxjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 11 Dec 2012 04:29:51 -0500, Vahid Keykhaey wrote:
> Dear Mr Delvare,
> Hi,
> My problem is, when I try to read per-core temperatures, there is not any
> information there. In my Core i7 processor, I can access per-core
> temperatures.
> My question is, is there any way to do this on this processor? My processor
> is Bulldozer 8120.

No, as far as I know this isn't possible, the AMD processors from
family 10h to 16h have a single digital temperature sensor embedded.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
