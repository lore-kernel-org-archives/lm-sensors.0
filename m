From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: 712
Message-Id: <3BE174AB.2CCA9F50@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1004614863.1545.25.camel@aurich>
In-Reply-To: <1004614863.1545.25.camel@aurich>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

can you please figure out why it isn't getting defined
so we can fix it?

Andree Leidenfrost wrote:
> 
> Hi,
> 
> Thanks for the hint. I investigated things and it looks like the problem
> is that CONFIG_SENSORS_W83781D is not getting defined. doing that
> manually in sensors.c fixes the problem.
> 
> Best regards & loads of thanks for your help,
> 
>         Andree
> --
> Dr Andree Leidenfrost, IT Consultant
> 
> Harms Consulting Pty Ltd
> PO Box 643 Bondi Junction NSW 1355 Australia
> Phone  +61 2 9365 0361, Fax +61 2 9300 9386
> Mobile +61 419 032 968
> www.harmsconsulting.com
