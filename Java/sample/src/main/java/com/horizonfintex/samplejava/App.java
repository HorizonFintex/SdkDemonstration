package com.horizonfintex.samplejava;

import com.horizonfintex.sdk.EthereumKit.EthereumCreator;
import com.horizonfintex.sdk.EthereumKit.EthereumOperator;
import com.horizonfintex.sdk.EthereumKit.EthereumKeystore;


/**
 * Hello world!
 */
public final class App {
    private App() {
    }

    /**
     * Says hello to the world.
     * @param args The arguments of the program.
     */
    public static void main(String[] args) {
        String keystoreJSON = "{\"version\":3,\"id\":\"e4f55744-8cad-4bf7-8b1b-8467ce1e8111\","
                                + "\"address\":\"d7e3064a1072232325f374043dc09795d1eb70df\",\"crypto\":"
                                + "{\"ciphertext\":\"d140d1bcb494d89c7429b1d798ccf4973b7a5802550fce8a1af728b432b95f6c\","
                                + "\"cipherparams\":{\"iv\":\"7adbf08d89335adb704b7073d613c389\"},\"cipher\":\"aes-128-ctr\",\"kdf\":\"scrypt\",\"kdfparams\":{\"dklen\":32,"
                                + "\"salt\":\"765863b83a96568df565accd7490e1f07a3ae36c81055e3afc71d164fc3885a7\",\"n\":8192,\"r\":8,\"p\":1},"
                                + "\"mac\":\"8f6bf094f9591a8314dfc0aba8b1e600ea3433fcadd049745f2aff70e811a078\"}}";


        EthereumOperator operator = EthereumCreator.createOperator();
        EthereumKeystore ethereumKeystore;
        try {
            ethereumKeystore = new EthereumKeystore(keystoreJSON);

            operator.signMessage("0xa734dfa607e04b1ebe6b2cf6b74d0192fdc6ec1b", ethereumKeystore, "Sh1l312018!", "hello world", (result, error) -> {
                System.out.println("result: " + result);
            });

            operator.changePwd(ethereumKeystore, "Sh1l312018!", "Hi!123432!!D", (result, error) -> {
                System.out.println("new wallet: " + result.getKeystoreString());
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
