From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 20 May 2005 09:54:31 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4 15/15]
Message-Id: <v0eBIb5C.1116575188.8501740.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20050519213551.GA806@kroah.com>
References: <e9iUj0EZ.1116327879.1515720.khali@localhost>
In-Reply-To: <e9iUj0EZ.1116327879.1515720.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: greg@kroah.com
Cc: Yani Ioannou <yani.ioannou@gmail.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>


Hi Greg,

> Hm, which makes me want to go look at trying to convert those attributes
> to an array right now...

I should probably develop my own thoughts and plans at this point then.

If you consider all the attributes of a given hardware monitoring driver,
you'll notice that, from a functional point of view, they can be
represented as two-dimension arrays rather than one-dimension ones. For
example, the temperature-related files of the it87 driver could be
represented this way:

+-------------+-------------+-------------+-------------+
| temp1_input | temp1_min   | temp1_max   | temp1_type  |
+-------------+-------------+-------------+-------------+
| temp2_input | temp2_min   | temp2_max   | temp2_type  |
+-------------+-------------+-------------+-------------+
| temp3_input | temp3_min   | temp3_max   | temp3_type  |
+-------------+-------------+-------------+-------------+

In the patch I just proposed, I made the choice to consider the colums of
the array above to create arrays of attributes, each column becoming a
different array. While it may sound like a sane choice, espcially when
there are many similar channels (e.g. voltages), it might not be the
best choice in the long run, for the following reason.

All measurement channels of the IT8705F and IT8712F can be individually
disabled. While this feature was almost not used so far, I think we
should have the driver not create interface files for disabled inputs.
In the case of temperature channels which can be dynamically enabled and
disabled. it would even make sense to dynamically create and delete
related sysfs files. Doing so would allow for memory savings and would
also be less error-prone for the user (presenting an interface for
disabled features is quite confusing IMHO).

For this reason, considering the lines of the array above, rather than
its columns, in order to define arrays of attributes, may be more subtle
and flexible in the long run.

Thanks
--
Jean Delvare
