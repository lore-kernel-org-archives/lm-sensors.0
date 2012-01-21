From: Tom Gundersen <teg@jklm.no>
Date: Sat, 21 Jan 2012 18:19:57 +0000
Subject: Re: [lm-sensors] w83627ehf can not be modprobed as of 3.3-rc1
Message-Id: <CAG-2HqU_o8iKQsuzN0CNCw23LX+UrfdCZ87AhVtJtgVcN-4fTw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAG-2HqVsLbpTrUAJ06AU-9_rOjQtkHap1ygYqpH_RBfM5ESb6w@mail.gmail.com>
In-Reply-To: <CAG-2HqVsLbpTrUAJ06AU-9_rOjQtkHap1ygYqpH_RBfM5ESb6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Jan 21, 2012 at 7:13 PM, Jean Delvare <khali@linux-fr.org> wrote:
> That was indeed a bug... in 3.2. Kernels between 2.6.39 and 3.2
> (inclusive) lack the ACPI resource conflict check, it was accidentally
> disabled. And this is fixed in 3.3.

Thanks. Sorry for the noise.

-t

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
