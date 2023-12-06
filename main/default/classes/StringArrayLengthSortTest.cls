@isTest
private class StringArrayLengthSortTest {

    @isTest static void testSortArrayBasedOnLength() {
        String testData = 'A sentence, with various lengths.';
        List<String> expected = new List<String>{'A', 'with', 'various', 'lengths', 'sentence'};

        Test.startTest();
        List<String> result = StringArrayLengthSort.sortArrayBasedOnLength(testData);
        Test.stopTest();

        Assert.areEqual(expected, result, 'The method did not sort the array based on length correctly');
    }

    @isTest static void testPunctuation() {
        String testData = 'Well,, hello there';
        List<String> expected = new List<String>{'Well', 'hello', 'there'};

        List<String> result = StringArrayLengthSort.sortArrayBasedOnLength(testData);

        Assert.areEqual(expected, result, 'The method did not handle punctuation correctly');
    }

    @isTest static void testEqualLengthStrings() {
        String testData = 'note boat coat';
        List<String> expected = new List<String>{'note', 'boat', 'coat'};

        List<String> result = StringArrayLengthSort.sortArrayBasedOnLength(testData);

        Assert.areEqual(expected, result, 'The method did not handle equal length strings correctly');
    }
}