From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Jun 2008 17:17:35 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (lm90) Support ADT7461 in
Message-Id: <20080616191735.24aa1673@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1213374973-3262-3-git-send-email-ncase@xes-inc.com>
In-Reply-To: <1213374973-3262-3-git-send-email-ncase@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 16 Jun 2008 11:50:04 -0500, Nate Case wrote:
> Quick question before I address all of your feedback with patch v2: You
> didn't mention these specifically, but I'm assuming you'd also want the
> tempX_from_reg_adt7461() functions to use u8 and u16 as well?

Hmm, yes, that would probably be more consistent that way; good idea.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
