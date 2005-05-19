From: andree.leidenfrost@harmsconsulting.com (Andree Leidenfrost)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: 712
Message-Id: <1004614863.1545.25.camel@aurich>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Thanks for the hint. I investigated things and it looks like the problem
is that CONFIG_SENSORS_W83781D is not getting defined. doing that
manually in sensors.c fixes the problem.

Best regards & loads of thanks for your help,

	Andree
-- 
Dr Andree Leidenfrost, IT Consultant

Harms Consulting Pty Ltd
PO Box 643 Bondi Junction NSW 1355 Australia
Phone  +61 2 9365 0361, Fax +61 2 9300 9386
Mobile +61 419 032 968
www.harmsconsulting.com
