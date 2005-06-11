From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 11 Jun 2005 00:25:25 +0000
Subject: [lm-sensors] Configuring ali1535 to show cpu temperature
Message-Id: <42AA1341.8060102@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <41e8ec0c05060811462b536e91@mail.gmail.com>
In-Reply-To: <41e8ec0c05060811462b536e91@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Please install lm_sensors on your computer
and run sensors-detect to see if there are any chips that are known.

Instructions how to do it are in lm_sensors package or web page.
If you have any more questions just ask.

Are you sure that acpi -V command do not show temperature?
Also  I know this notebooks as buggy acpi so you need DSDT fix to get fans working. Is it your case?

Regards
Rudolf
