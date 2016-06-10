It is important to have consistency across the codebase. This won't necessarily make your code work better, but it might help make it more understandable and less irritating to go through when doing a code review, extending with new functionality, or adding code to.

* Within methods, please try to leave spaces between logical units of code to improve readability.

* Please, use four spaces, instead of a tab.

* When re-indenting code, please make a single commit with just the indentation changes and make sure you describe them in the commit message. Mixing a re-indentation and actual functional changes in the same commit make things much less easier to track and figure out.

Please, consider the following an example of how to indent your code.

```
package com.bar;

/**
 * License header goes here.
 */
import com.foo.*;
import com.foo.dot.*;
import java.util.*;

/**
 * @author john.doe
 */
public class Foo extends TestCase
    implements Serializable
{
    
    private int[] X = new int[]{ 1, 3, 5
                                 7, 9, 11 };
    
    private String[] strings = new String[] { "Some text",
                                              "Some other text",
                                              "And a lot more text" };
    
    
    public void setUp()
    {
        super.setUp();
    }
    
    public void test(boolean a,
                     int x,
                     int y,
                     int z)
    {
        label1:
        do
        {
            try
            {
                if (x > 0)
                {
                    int someVariable = x + y == z ?
                                       x + 1:
                                       y + 2;
                }
                else if (x < 0)
                {
                    int someVariable = (y +
                                        z);
                    someVariable = x =
                                   x +
                                   y;
                    String string1 = "This is a long" +
                                     " string which contains x = " +
                                     x;
                }
                else
                {
                    label2:
                    for (int i = 0; i < 5; i++)
                        doSomething(i);
                }
                switch (a)
                {
                    case 0:
                        doCase0();
                        break;
                    default:
                        doDefault();
                }
            }
            catch (Exception e)
            {
                processException(e.getMessage(), x + y, z, a);
            }
            finally
            {
                processFinally();
            }
        }
 
        if (2 < 3)
        {
            return;
        }

        if (3 < 4)
        {
            return;
        }
        else
        {
            break;
        }
 
        do
        {
            x++;
        }
        while (x < 10000);
        
        while (x > 0)
        {
            System.out.println(x--);
        }

        for (int i = 0; i < 5; i++)
        {
            System.out.println(i);
        }
        
        for (int i = 0; i < 5; i++)
        {
            if (i != 1)
            {
                System.out.println(i);
            }
            else
            {
                System.out.println("This is it.");
            }
        }
    }
    
    private class InnerClass
        implements I1,
                   I2
    {
        public void bar()
                throws E1,
                       E2
        {
            System.out.println("bar");
        }
    }
    
}
```

Code Styles
* [strongbox-idea.xml](https://raw.githubusercontent.com/wiki/strongbox/strongbox/resources/codestyles/strongbox-idea.xml)
* [strongbox-eclipse.xml](https://raw.githubusercontent.com/wiki/strongbox/strongbox/resources/codestyles/strongbox-eclipse.xml)
