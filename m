From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 21 Jun 2005 11:00:55 +0000
Subject: [lm-sensors] RE: w83792d driver for the 2.6 kernel
Message-Id: <gNdsuslU.1119344166.0115450.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE5E7741@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE5E7741@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Fabien,

> Thanks a lot for the patch. It works pretty well (i.e. we see meaningful
> values when we run sensors -u) but the user tools are not up to date :
>  - sensors-detect fails to detect the w83792d
>  - the "sensors" output only includes the old w83627hf data

Did you update the lm_sensors user-space tools as Rudolf Marek
recommended? Support for the W83792D is in CVS only.

--
Jean Delvare
