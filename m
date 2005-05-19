From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: website download.html
Message-Id: <3EDF75F0.4050907@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020823210408.1d4a8289.khali@linux-fr.org>
In-Reply-To: <20020823210408.1d4a8289.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>>Doesn't it mean that HEAD should become lk2-5 or old or obsolete or
>>>whatever, and lk2-4 should become HEAD again?
>>
>>is that possible?
> 
> 
> I don't know. I'm no CVS expert, I just feel we *should* be able to do
> so. I was actually told a few minutes ago that it wasn't easily
> feasable... :(
> 

You should be able to make this happen forceably, by checking out the 
HEAD then replacing the file tree with the files from a lk2-5 or lk2-4 
tree and then checking the result back into the HEAD.

It's low-tech, but it should work...

-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
