#
# Use supplied test_cases, `ddmin` and the given `mystery_test`
# to find the minimal length string that causes
# `mystery_test` to return 'FAIL'.
# `mystery_test` takes 2 arguments:
# first is test case index, second is test string.
# The minimized test cases should go into the `answer`
# variable in the same order as test_cases.
# If your code Runs fine, but times out on Submit,
# just copy the found strings in the answer variable.

test_cases = ['<vbox><listbox rows="2"><listitem label="listitem"/><listitem><html:input type="checkbox" style="margin:0px;"/></listitem></listbox></vbox>',
              '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head><meta http-equiv="Content-Type" content="text/html;charset=utf-8"><title>wushi0016</title><script type="text/javascript">function goodbye() {nodeList = document.getElementsByTagName("input");testNode = nodeList.item(0);testNode.type = "yabba-dabba-do";return testNode.blur();}</script></head><body onload="goodbye()"><input type="file" /></body></html>',
              '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"><html lang="en"><head></head><body><p><b>BUG ID:</b> <a href="http://bugs.webkit.org/show_bug.cgi?id=3855">Bugzilla Bug 3855</a> Table with Form Field and Hidden DIV crashes Safari</p><p id="test" style="background-color:skyblue; padding:3px;"><b>STEPS TO TEST:</b>Type in the text field below.</p><p id="success" style="background-color:palegreen; padding:3px;"><b>TEST PASS:</b>Safari will not crash, text will show up in text field as expected.</p><p id="failure" style="background-color:#FF3300; padding:3px;"><b>TEST FAIL:</b>Safari will crash.</p>Type in the input field below:<form><div style="display:none;"><table><tr><td>test</td></tr></table></div><input type="text" value="" /></form></body></html>',
              '<form name="changeform" id="changeform" method="post" action="process_bug.cgi"><input type="hidden" name="delta_ts" value="2007-04-26 07:34:56"><input type="hidden" name="longdesclength" value="8"><input type="hidden" name="id" value="356999"><input type="hidden" name="token" value="1346633823-befc508ae6f90d359299be7ea39c463a"><div class="bz_alias_short_desc_container edit_form"><span class="last_comment_link"><a href="#c7" accesskey="l"><b>L</b>ast Comment</a></span><a href="show_bug.cgi?id=356999"><b>Bug&nbsp;356999</b></a> -<span id="summary_alias_container" class="bz_default_hidden"> <span id="short_desc_nonedit_display">&lt;html:input type=&quot;text&quot;&gt; inside scaled &lt;svg:foreignObject&gt; is horribly broken</span></span><div id="summary_alias_input"><table id="summary"><td colspan="2">          </td>        </tr><tr><td><label accesskey="s" for="short_desc"><u>S</u>ummary</label>:</td><td>&lt;html:input type=&quot;text&quot;&gt; inside scaled &lt;svg:foreignObject&gt; is horribly broken          </td>        </tr>      </table>    </div>  </div><input type="range" value="2" min="-5" max="5" step="1"></form>',
              '<div id="content">     <div class="indent-main">        <div class="indent">            <div class="container">                <div class="col-1">                    <div class="indent-col1">                        <h1 class="title">Welcome</h1>                        <p class="p1">Welcome Pet Lovers! &nbsp;Here you\'ll find just what you\'re looking for - with a big extra bonus: FUN! &nbsp;Sure, you could buy that catnip or dog toy anywhere else, but here at the Go-To Guide, we are SERIOUSLY committed to making you SMILE. &nbsp;Maybe even LAUGH!</p>                      <div class="box">                            <div class="border-top">                                <div class="border-bottom">                                    <div class="corner-top-right">                                        <div class="corner-top-left">                                            <div class="corner-bottom-left">                                                <div class="corner-bottom-right">                                                   <div class="indent-box">                                                        <div class="container">                                                          <div class="col-3">                                                                <img alt="" src="images/1page_img1.jpg" class="img-indent" /><br />                                                              <a href="#" class="link2"><strong>News</strong></a> <br />                                                                <ul class="boxlist">                                                                   <li>Link to News Story</li>                                                                   <li>Link to News Story 2</li>                                                                   <li>Link to News Story 3</li>                                                                </ul>                                                               </div>                                                            <div class="col-3">                                                                <img alt="" src="images/1page_img2.jpg" class="img-indent" /><br />                                                              <a href="#" class="link2"><strong>Information</strong> <br />                                                               &nbsp; &nbsp; &nbsp; &nbsp;mau <span>rillus</span> </a>                                                            </div>                                                            <div class="col-3">                                                                <img alt="" src="images/1page_img3.jpg" class="img-indent" /><br />                                                              <a href="#" class="link2"><strong>Products</strong> <br />                                                               &nbsp; &nbsp; &nbsp; &nbsp;cumsoci <span>inatot</span> </a>                                                            </div>                                                            <div class="col-4">                                                                <img alt="" src="images/1page_img4.jpg" class="img-indent" /><br />                                                              <a href="#" class="link2"><strong>Services</strong> <br />                                                              &nbsp; &nbsp; &nbsp; &nbsp;us etgnis <span>sriea</span>  </a>                                                          </div>                                                        </div>                                                    </div>                                                </div>                                            </div>                                        </div>                                    </div>                                </div>                            </div>                        </div>                        <img alt="" src="images/1page_title2.gif" class="title1" /><br />                        <p><strong>04/18/2009 - 14:53</strong></p>']

from ps3_mystery import mystery_test as test
import random

def ddmin(i, s):
    n = 2     # Initial granularity
    while len(s) >= 2:
        start = 0
        subset_length = len(s) / n
        some_complement_is_failing = False

        while start < len(s):
            complement = s[:start] + s[start + subset_length:]

            # MYSTERY test TAKES 2 ARGUMENTS
            # FIRST IS TEST CASE INDEX
            # SECOND IS THE STRING TO TEST
            if test(i, complement) == "FAIL":
                s = complement
                n = max(n - 1, 2)
                some_complement_is_failing = True
                break

            start += subset_length

        if not some_complement_is_failing:
            if n == len(s):
                break
            n = min(n * 2, len(s))
    return s

answer = ['' for _ in test_cases] # YOUR ANSWER SHOULD GO IN THIS VARIABLE
for i in range(5):
    answer[i] = (ddmin(i, test_cases[i]))
