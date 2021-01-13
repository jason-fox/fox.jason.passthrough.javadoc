package fox.jason.passthrough;

import java.io.File;
import java.io.IOException;

public class JavadocReader extends AntTaskFileReader {

  public JavadocReader() {
  }

  private static final String ANT_FILE = "/../process_javadoc.xml";

  @Override
  protected String runTarget(File inputFile, String title)
    throws IOException {
    return executeAntTask(
      calculateJarPath(JavadocReader.class) + ANT_FILE,
      inputFile,
      title
    );
  }
}
