From: Guenter Roeck <groeck-dsl@sbcglobal.net>
Date: Tue, 11 Dec 2012 14:45:58 +0000
Subject: Re: [lm-sensors] Driver for Bulldozer
Message-Id: <20121211144558.GB30334@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAMcsHH20xPDkTq7+9KyxDodnNYKB+UNS3_T=Exfq=BfP+kaxjw@mail.gmail.com>
In-Reply-To: <CAMcsHH20xPDkTq7+9KyxDodnNYKB+UNS3_T=Exfq=BfP+kaxjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Dec 11, 2012 at 11:52:35AM +0100, Jean Delvare wrote:
> On Tue, 11 Dec 2012 14:17:14 +0330, Vahid Keykhaey wrote:
> > Thanks, it is fixed now. As the final question, is there any hope that
> > there would be a situation to read per core temperatures in the Bulldozer
> > processor?
> 
> No, this is a hardware limitation, you can't read values from sensors
> that do not exist in the hardware.
> 
I thought maybe he only needs the pci id added to the k10temp driver. That was a
wild guess only, though.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
