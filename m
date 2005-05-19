From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: Query on apparently 'disconnected' sysfs interfaces
Message-Id: <423B62D8.8030808@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <pa6k311f7c2hhul35cifmso9g54ovrnu8c@4ax.com>
In-Reply-To: <pa6k311f7c2hhul35cifmso9g54ovrnu8c@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Jean Delvare wrote:

>Hi Grant,
>  
>
>>in1_ref
>>vid		< cpu0_vid?
>>    
>>
>
>Both should cpu0_vid, drivers need to be fixed.
>  
>

Don't forget that there are dual CPU motherboards and some have only one 
VID while others have two VID's.

I suppose that's why you're adding cpu0_ to the name, but the existing 
practice is clear that the vast majority of monitoring chips use the 
name 'vid'.  (Which driver uses in1_ref?)  Changing to cpu0_vid or 
cpu1_vid would seem to be a major change which should not be undertaken 
lightly since this is likely to be one of the values *most* referenced 
by user scripts and applications.

:v)

-- 
Philip Pokorny, Director of Engineering
Tel: 415-954-2823   Fax: 415-954-2899   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
